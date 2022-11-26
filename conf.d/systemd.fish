# Aliases
alias sc 'sudo systemctl'
alias sce 'sudo systemctl enable'
alias scd 'sudo systemctl disable'
alias scs 'sudo systemctl start'
alias sct 'sudo systemctl stop'
alias scr 'sudo systemctl restart'
alias scst 'sudo systemctl status'
alias scdr 'sudo systemctl daemon-reload'

function eu # Edit unit file and reload daemon
    sudo nano /usr/lib/systemd/system/$argv[1].service
    sudo systemctl daemon-reload
end

function et # Edit timer file and reload daemon
    sudo nano /usr/lib/systemd/system/$argv[1].timer
    sudo systemctl daemon-reload
end

function ru # Reload unit file and follow logs
    sudo systemctl restart $argv[1]
    sudo journalctl -u $argv[1] -f
end

function sch # Perform a service check
    for SERVICE in $argv
        if sudo systemctl is-active $SERVICE --quiet
            echo 🟢 $SERVICE is active.
        else
            echo 🔴 $SERVICE is inactive.
        end
    end
end

function rch # Restart services and perform a service check
    for SERVICE in $argv
        if sudo systemctl is-active $SERVICE --quiet
            echo 🟢 $SERVICE is active, restarting...
            sudo systemctl restart $SERVICE
        else
            echo 🔴 $SERVICE is inactive, starting...
            sudo systemctl restart $SERVICE
        end

        sleep 10

        if sudo systemctl is-active $SERVICE --quiet
            echo 🟢 $SERVICE is active.
        else
            echo 🔴 $SERVICE is inactive.
        end
    end
end
